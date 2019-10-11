<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="/guide/resources/css/bootstrap.css">
  <link rel="stylesheet" href="/guide/resources/css/codingBooster.css">
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/guide/resources/loading-bar/loading-bar.js"></script>
<link rel="stylesheet" type="text/css" href="/guide/resources/loading-bar/loading-bar.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script>
var bar1;
var bar2;
var now = 0;
var myInterval
	$(function(){
		 bar1 = new ldBar("#myItem1");
		  bar2 = document.getElementById('myItem1').ldBar;
		  bar1.set(0);
		  loadingGo(4000)
		  
		analysis();
	})
	function recommendBar(){
	  bar1 = new ldBar("#myItem2");
	  bar2 = document.getElementById('myItem2').ldBar;
	  bar1.set(0);
	  loadingGo(3000)
	}
	function loadingGo(number){
		now = 0;
		  myInterval = setInterval(function() {
				now += 2;
				bar1.set(now);
				clearInt(now)
				}, number);
		  }
  function clearInt(now){
  if(now == 80){
	  clearTimeout(myInterval);
  }
}


	function analysis(){
		$.ajax({
			url:"/guide/analysis/analysis",
			type:"get",
			datatype:"json",
			success:function(item){
				clearInt(80);
				bar1.set(100);
				getGraph(item.hotelPoint,item.famousPoint,item.foodPoint,item.distPoint,item.foodDiversity)
				tripType(item);
				getTotalTime();
				getFoodShop()
				getTabe();
				getHotel();
				getYahoo();
				 $('.loader').animate({opacity: "0"}, 1000);
				setTimeout(function()
					    {
							$(".loader").remove();
							$(".cons").css('display','block')
							$('.cons').animate({opacity: "1"}, 1500);
							recommendBar();
							getRecommend()
					    },1000);

				
					
			}
		})
	}
	function getTotalTime(){
		$.ajax({
			url:"/guide/analysis/analysis/getTotalTime",
			type:"get",
			datatype:"json",
			success:function(item){
				$("#result > div:nth-child(2) > div:nth-child(2) > div > table > tbody > tr:nth-child(2) > td:nth-child(2)").text(changeTime(item.walkTotalTime));
				$("#result > div:nth-child(2) > div:nth-child(2) > div > table > tbody > tr:nth-child(3) > td:nth-child(2)").text(changeTime(item.carTotalTime));
			}
		})
	}
	function changeTime(times){
		var result = "";
		var time = times.split(":")
		if(time[0]=="0"){
			result = time[1] + " 分";
		}else if(time[1]=="00"){
			result = time[0] + " 時間";
		}
		else{
			result = time[0] + " 時間"+ time[1]+ " 分";
		}
		return result;
	}
	function getHotel(){
		var result = 0 ;
		var price = 0;
		var lastNumber = 0;
		$.ajax({
			url:"/guide/analysis/analysis/getHotelList",
			type:"get",
			datatype:"json",
			success:function(item){
				$(item).each(function(i,mono){
					result += mono.hotelStar;
					lastNumber = i;
				})
				$("#result > div:nth-child(2) > div:nth-child(2) > div > table > tbody > tr:nth-child(4) > td:nth-child(2)").text(result/(lastNumber+1))
			}
		})
	}
	function getRecommend(){
		$.ajax({
			url:"/guide/analysis/analysis/getRecommend",
			type:"get",
			datatype:"json",
			success:function(item){
				clearInt(80);
				bar1.set(100);
				setTimeout(function(){
					$('#myItem2').animate({opacity: "0"}, 1000);
				$(item).each(function(i,mono){
					if(i<2){
					$('#recomFood').append(
						'<td width="250" height="40">'+
						'<a href="'+mono.links+'" target="_blank" style="font-size:20px;">'+mono.name+'</a>'+
						'</td>'		
					)
					}else{
						$('#recomTrip').append(
							'<td width="250" height="40">'+
							'<a href="'+mono.links+'" target="_blank" style="font-size:20px;">'+mono.name+'</a>'+
							'</td>'
						)
					}
				})
				$('#myItem2').remove();
				$("#recommended").css("display","block");
				$('#recommended').animate({opacity: "1"}, 1000);
				},2000)
			}
		})
	}
	function tripType(item){
		var hotelPoint = item.hotelPoint
		var famousPoint = item.famousPoint
		var foodPoint = item.foodPoint
		var distPoint = item.distPoint
		var foodDiversity = item.foodDiversity
		var result = "";
		var whyReuslt ="";
		var color = "#6f42f5";
		
		if(hotelPoint>2.5){hotelPoint=true;}
		else{hotelPoint=false;}
		
		if(famousPoint>2.5){famousPoint=true;}
		else{famousPoint=false;}
		
		if(foodPoint>2.5){foodPoint=true;}
		else{foodPoint=false;}
		
		if(distPoint>2.5){distPoint=true;}
		else{distPoint=false;}
		
		if(foodDiversity>2.5){foodDiversity=true;}
		else{foodDiversity=false;}
		
		if(hotelPoint&&famousPoint&&foodPoint&&distPoint&&foodDiversity){
			result = "東京ドリーマー";
			whyResult = "完璧な旅行タイプです！"+"<br>"+"もし日本人ですか？！。";
		}else if(!hotelPoint&&!famousPoint&&!foodPoint&&!distPoint&&!foodDiversity){
			result = "素人";
			whyResult = "旅行が初めですか！"+"<br>"+"少し調査が必要だと思います。";
			color = "#f54275";
		}else if(famousPoint&&foodPoint&&distPoint&&foodDiversity){
			result = "寝ることより旅行";
			whyResult = "ホテルは関係なし！"+"<br>"+"どんなことより観光に集中しますね！。";
			color = "#9342f5";
		}else if(hotelPoint&&foodPoint&&distPoint&&foodDiversity){
			//famu x
			result = "すごい探検者"
			whyResult = "有名な場所より静かところがすきですか？！。"+"<br>"+"多分、日本に来たことが多いと思います。";
			color = "#9342f5";
		}else if(hotelPoint&&famousPoint&&distPoint&&foodDiversity){
			//food x
			result = "食べ物はただの必要なことしかならない。";
			whyResult = "食べ物はただ、生きるためのものだと思いますか？！。"+"<br>"+"食べ物はかまわありませんね！。";
			color = "#9342f5";
		}else if(hotelPoint&&famousPoint&&distPoint&&foodPoint){
			// div x
			result = "日本文化専門家";
			whyResult = "日本に来たから日本文化を楽しみますか？！。"+"<br>"+"すごい計画だと思います！。";
			color = "#9342f5";
		}else if(hotelPoint&&famousPoint&&foodDiversity&&foodPoint){
			// dist x
			result = "流れ者";
			whyResult = "遠い所が多いことが多分、日本をよく知っていると思います！。";
			color = "#9342f5";
			//-----
		}else if(hotelPoint&&foodPoint&&famousPoint){
			// div , dist x
			result = "運転者";
			whyResult = "遠い所が多いことが多分、日本に興味があると思います！。";
			color = "#c542f5";
		}else if(hotelPoint&&famousPoint&&foodDiversity){
			// dist , food x
			result = "日本文化研究者";
			whyResult = "遠い所が多いことが多分、日本に興味があると思います！。";
			color = "#c542f5";
		}else if(hotelPoint&&distPoint&&foodDiversity){
			// food , fam x
			result = "効率的な流れ者";
			whyResult = "食べ物はただ、生きるためのものだと思いますか？！。"+"<br>"+"食べ物はかまわありませんね！。";
			color = "#c542f5";
		}else if(foodPoint&&distPoint&&foodDiversity){
			// fam , hotel x
			result = "日本の食堂研究者";
			whyResult = "食べ物が一番重要だと思う人ですね！"+"<br>"+"美味しい食べ物が好きらしい！";
			color = "#c542f5";
		}else if(distPoint&&famousPoint&&foodDiversity){
			//hotel , food x
			result = "旅行の目的は観光";
			whyResult = "誰かより観光が重要ですか！？"+"<br>"+"でも日本には美味しい食べ物が多いですからもっと探してください！。";
			color = "#c542f5";
		}else if(foodDiversity&&famousPoint&&foodPoint){
			// hotel , dist x
			result = "日本の食堂研究者";
			whyResult = "食べ物が一番重要だと思う人ですね！"+"<br>"+"美味しい食べ物が好きらしい！";
			color = "#c542f5";
		}else if(distPoint&&famousPoint&&foodPoint){
			// hotel , div x
			result = "効率的な流れ者";
			whyResult = "他のホテルを探したらどうですか？！。"+"<br>"+"もっと完璧な旅行ができますよ！！。";
			color = "#c542f5";
		}else if(foodPoint&&hotelPoint&&foodDiversity){
			// fam , dist x
			result = "休みたい人";
			whyResult = "観光より休みたいと思いますか？！。"+"<br>"+"大変な生活から逃げたいと思います！！。";
			color = "#c542f5";
		}else if(foodPoint&&distPoint&&hotelPoint){
			// fam , div x
			result = "休みたい人";
			whyResult = "観光より休みたいと思いますか？！。"+"<br>"+"大変な生活から逃げたいと思います！！。";
			color = "#c542f5";
		}else if(famousPoint&&distPoint&&hotelPoint){
			//food , div x
			result = "旅行の目的は観光";
			whyResult = "誰かより観光が重要ですか！？"+"<br>"+"でも日本には美味しい食べ物が多いですから"+"<br>"+"もっと探してください！。";
			color = "#c542f5";
		}else if(foodDiversity&&distPoint){
			// hotel , fam , food x
			result = "効率的しかない";
			whyResult = "何か距離だけ考えましたか！？"+"<br>"+"もっと探して良いところに行ってください！。";
			color = "#f542cb"
		}else if(foodDiversity&&hotelPoint){
			// dist , fam , food x
			result = "ホテルマン";
			whyResult = "ただ、ホテルで休む予定ですか？！"+"<br>"+"新しい食べ物でも探したらどうか！。";
			color = "#f542cb"
		}else if(famousPoint&&hotelPoint){
			result = "普通のツアーリスト";
			whyResult = "本当に普通な旅行だと思います。"+"<br>"+"新しい物を探してください！";
			color = "#f542cb"
		}else if(famousPoint&&distPoint){
			result = "効率的しかない";
			whyResult = "誰かより観光が重要ですか！？"+"<br>"+"でも日本には美味しい食べ物が多いですから"+"<br>"+"もっと探してください！。";
			color = "#f542cb"
			// hotel , food , div x
		}else if(famousPoint&&foodDiversity){			
			// hotel , food , dist x
			result = "普通のツアーリスト";
			whyResult = "本当に普通な旅行だと思います。"+"<br>"+"新しい物を探してください！";
			color = "#f542cb"
		}else if(hotelPoint&&foodPoint){
			// fam , div , dist x
			result = "休憩者"
			whyResult = "ただ、休みたいならこれでも大丈夫です！"+"<br>"+"でも、観光もしたらどうでしょうか？！";
			color = "#f542cb"
			
		}else if(foodPoint&&foodDiversity){
			//hotel , famu , dist ,
			result = "食べるために生きる";
			whyResult = "ただ、休みたいならこれでも大丈夫です！"+"<br>"+"でも、観光もしたらどうでしょうか？！";
			color = "#f542cb"
		}else if(foodPoint&&distPoint){
			//hotel , famu , div , 
			result = "効率的しかない";
			whyResult = "誰より食べ物しか重要だとしていますか！？"+"<br>"+"でも日本には素晴らしい観光地が多いですから"+"<br>"+"もっと探してください！。";
			color = "#f542cb"
		}else if(hotelPoint&&distPoint){
			//food , famu , div x
			result = "効率的しかない";
			whyResult = "誰よりホテルが重要だとしていますか！？"+"<br>"+"でも日本には色々なことが多いですから"+"<br>"+"もっと探してください！。";
			color = "#f542cb"
		}else if(hotelPoint){
			result = "ホテル観光";
			whyResult = "もと検索して計画を詳しくしてください！。";
			color = "#f54275";
		}else if(foodPoint){
			result = "お腹がすいたい";
			whyResult = "もと検索して計画を詳しくしてください！。";
			color = "#f54275";
		}else if(famousPoint){
			result = "観光で終わり";
			whyResult = "もと検索して計画を詳しくしてください！。";
			color = "#f54275";
		}else if(foodDiversity){
			result = "お腹がすいたい";
			whyResult = "もと検索して計画を詳しくしてください！。";
			color = "#f54275";
		}else if(distPoint){
			result = "効率的しかない";
			whyResult = "もと検索して計画を詳しくしてください！。";
			color = "#f54275";
		}else{
			result = "글쌔";
			whyResult = "もと検索して計画を詳しくしてください！。";
			color = "#f54275";
		}
		$("#triptype").text("「　"+result+"　」")
		$("#myTrips").append(whyResult)
		$("#triptype").css("color",color);
	}
	
	function getFoodShop(){
		var dayresult = 0 ;
		var nightresult = 0 ;
		$.ajax({
			url:"/guide/analysis/analysis/getFoodList",
			type:"get",
			datatype:"json",
			success:function(item){
				$(item).each(function(i,mono){
					dayresult += mono.marketDayPrice					
				})
				dayresult += "円";
				$("#result > div:nth-child(2) > div:nth-child(2) > div > table > tbody > tr:nth-child(1) > td").text(dayresult)
			}
		})
	}
	function getYahoo(){
		var yahooArray = [[0,0],[0,0],[0,0],[0,0],[0,0]];
		$.ajax({
			url:"/guide/analysis/analysis/getYahooList",
			type:"get",
			datatype:"json",
			success:function(item){
				$(item).each(function(i,item){
					yahooArray[i] = [item.walkLength,item.route];
				})
				barChart(yahooArray);
			}
		})
	
	}
	function getTabe(){

		var Japan,Western,Asia,Minority,Fusion,Drinks,Cafe,Desert
		$.ajax({
			url:"/guide/analysis/analysis/getTabeList",
			type:"get",
			datatype:"json",
			success:function(item){
				Japan = item.Japan
				Western = item.Western
				Asia = item.Asia
				Minority = item.Minority
				Fusion = item.Fusion
				Drinks = item.Drinks
				Cafe = item.Cafe
				Desert = item.Desert
				pieChart(Japan,Western,Asia,Minority,Fusion,Drinks,Cafe,Desert);
			}
		})
	
	}
	function getGraph(hotelPoint,famousPoint,foodPoint,distPoint,foodDiversity){
		var marksCanvas = document.getElementById("marksChart");
		Chart.defaults.global.defaultFontFamily = "Lato";
		Chart.defaults.global.defaultFontSize = 18;
		var marksData = {
		  labels: ["観光地点数", "店の点", "距離点数", "ホテル点数", "色々な"],
		  datasets: [{
		    label: "自分",
		    backgroundColor: "rgba(130, 193, 255,0.2)",
		    borderColor: "rgba(130, 193, 255,0.6)",
		    fill: '-1',
		    radius: 6,
		    pointRadius: 6,
		    pointBorderWidth: 3,
		    pointBackgroundColor: "rgba(64, 161, 255,0.6)",
		    pointBorderColor: "rgba(130, 193, 255,0.6)",
		    pointHoverRadius: 10,
		    data: [famousPoint, foodPoint, distPoint, hotelPoint, foodDiversity]
		  }]
		};

		var chartOptions = {
		  scale: {
		    gridLines: {
		      color: "rgba(237, 237, 237,0.4)",
		      lineWidth: 2
		    },
		    angleLines: {
		      display: false
		    },
		    ticks: {
		      beginAtZero: true,
		      fontColor: "rgba(150, 150, 150,1)",
		      fontSize:10,
		      min: 0,
		      max: 5,
		      stepSize: 1
		    },
		    pointLabels: {
		      fontSize: 18,
		      fontColor: "rgba(13, 0, 158,0.7)",
		    }
		  },
		  legend: {
		    position: 'left'
		  }
		};
		var radarChart = new Chart(marksCanvas, {
		  type: 'radar',
		  data: marksData,
		  options: chartOptions
		});

		
	}
	function barChart(yahooArray){
		new Chart(document.getElementById("bar-chart-horizontal"), {
		    type: 'horizontalBar',
		    data: {
		      labels: ["관광차트"],
		      datasets: [
		        {
		          label: [yahooArray[0][1]],
		          backgroundColor: ["rgba(17, 0, 255,0.6)"],
		          data: [yahooArray[0][0]]
		        },
		        {
		          label: [yahooArray[1][1]],
		          backgroundColor: ["rgba(61, 110, 255,0.6)"],
		          data: [yahooArray[1][0]]
		        },
		        {
		          label: [yahooArray[2][1]],
		          backgroundColor: ["rgba(61, 145, 255,0.6)"],
		          data: [yahooArray[2][0]]
		        },
		        {
		          label: [yahooArray[3][1]],
		          backgroundColor: ["rgba(61, 197, 255,0.6)"],
		          data: [yahooArray[3][0]]
		        },
		        {
		        label: [yahooArray[4][1]],
		          backgroundColor: ["rgba(61, 239, 255,0.6)"],
		          data: [yahooArray[4][0]]
		        }		        
		      ],
		    options: {
		    	scales: {
		    		xAxes: [{
		                display: true,
		                scaleLabel: {
		                    display: true,
		                    labelString: 'x축'
		                },
		                ticks: {
		                    autoSkip: false
		                }
		            }],
		    		yAxes: [{
		                display: true,
		                ticks: {
		                    suggestedMin: 0,
		                },
		                scaleLabel: {
		                    display: true,
		                    labelString: 'x축'
		                }
		            }]
		           
		    	},
		      legend: { display: false },
		      title: {
		        display: true,
		        text: 'your HotelList'
		      }
		      
		    }
		    }
		 });
	}
	function pieChart(n1,n2,n3,n4,n5,n6,n7,n8){
		new Chart(document.getElementById("pie-chart"), {
		    type: 'pie',
		    data: {
		      labels: ["和食", "洋食", "アジア料理", "国籍料理", "創作料理","お酒","カフェ","パン・サンドイッチ"],
		      datasets: [{
		        label: "Population (millions)",
		        backgroundColor: ["rgb(240, 94, 72)", "#f09648","#f0f048","#83f048","#48f0bb","#488ef0","#5648f0","rgba(159, 72, 240,0.5)"],
		        data: [n1,n2,n3,n4,n5,n6,n7,n8]
		      }]
		    },
		    options: {
		      title: {
		        display: false,
		        text: 'Your FamousFood List'
		      }
		    
		    }
		});
		
	}
	function doNotReload(){
		if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) //ctrl+N , ctrl+R
		|| (event.keyCode == 116)) // function F5
		{
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
		location.href = "/guide/analysis/goAnalysis"
		}
		}
		document.onkeydown = doNotReload;
	
</script>
<style>
#myTrips{
	font-size: 22px;
}
#triptype{
	font-size:35px;
}

.inder{
	width:50%;
	
}
 .ldBar-label {
   color: #50d7f2;
   
   font-size: 21px;
   font-weight: 900
 }

</style>
</head>
<body>
<body>
<div class="loader" style="padding:70px 0;">
<div id="myItem1" class="ldBar label-center" style="width:30%;height:30%;margin:auto" data-value="0" data-preset="circle"></div>
</div>
<div class="cons" style="display:none; opacity:0;">
<jsp:include page="/WEB-INF/views/Topbar.jsp" />
<div style="display:block; width:70%; text-align:center; margin-left:15%;">
	<div style="font-size:70px;font-weight:bold; color:#57d5e6; margin:100px 100px;"> あなたの計画分析結果</div>
	<div id="graph" style=" text-align: center;">
		<div style="width: 1000px; height: 1000px;">
		<canvas id="marksChart" ></canvas>
		 </div>
		 <div style="width: 1000px; height:600px; magin-top:50px;">
		 	<canvas id="pie-chart" width="800" height="450" style=""></canvas>
		 </div>
		 <div style="width: 1000px; height:600px; magin-top:50px;">
		 	<canvas id="bar-chart-horizontal" width="800" height="450"></canvas>
		 </div>
	 </div>
	 <div id="result" style="text-align:center;width:1000px;height:1000px;display:block; margin-top:100px;">
	 	<div class="title">
	 		<h1 style="font-size:50px;">あなたの旅行タイプは<span id="triptype"></span> だと思います。</h1>
	 	</div>
	 	<div style="display:inline-flex; margin-top:100px;">
	 		<div class="inder">
	 			<h1 style="color:#57d5e6;">その理由は</h1>
	 			<div id ="myTrips"style="float:left; margin-top: 30px;">	 					 				
	 			</div>
	 		</div>
	 		<div class="inder" >
	 			<h1 style="color:#57d5e6;">その他の</h1>
	 			<div style="text-align:center;">
	 				<table style="text-align:left; margin-top: 30px;">
	 					<tr>
	 						<th width="350" height="40" style="font-size:25px;">食事経費　 :
	 						</th>
	 						<td width="200" height="40" style="font-size:25px;">
	 						</td>
	 					</tr>
	 				
	 					<tr>
	 						<th width="350" height="40" style="font-size:25px;">歩いて旅行したら :  
	 						</th >
	 						<td width="200" height="40" style="font-size:25px;">
	 						</td>
	 					</tr>
	 					<tr>
	 						<th width="350" height="40" style="font-size:25px;">自動車で旅行したら : 
	 						</th>
	 						<td width="200" height="40" style="font-size:25px;">
	 						</td>
	 					</tr>
	 					<tr>
	 						<th width="350" height="40" style="font-size:25px;">ホテルレベル : 
	 						</th>
	 						<td width="200" height="40" style="font-size:25px;"	>
	 						</td>
	 					</tr>
	 				</table>
	 			</div>
	 		</div>
	 	</div>
	 	<h1 style="margin-left:30px; margin-top:50px;color: #50d7f2;">おすすめ</h1>
	 	<div id="myItem2" class="ldBar label-center" style="width:60%;height:30%;margin:auto" data-value="0" data-preset="line"></div>
	 <div id="recommended" style="display:none; opacity:0; padding:30px 30px;">
	 	<div><h4>あなたに合うと思う観光地と食堂をおすすめします！<br>このところはあなたが入力した計画を<br>分析しておすすめします！</h4><br>興味があったら、<span style="color:#50d7f2;">名前をクリック</span>してください！</div>
	 	
	 	<table style="margin-top:50px;">
	 		<tr id="recomFood" >
				<th width="350" height="40" style="font-size:25px; float:left;">食堂をおすすめ :
				</th>
			</tr>
			<tr id="recomTrip" style="margin-top:20px;">
				<th width="350" height="40" style="font-size:25px; float:left;">観光地おすすめ :
				</th>
			</tr>
	 	
	 	</table>
	 	</div>
</div>
	 	
	 
	 </div>
	 <jsp:include page="/WEB-INF/views/BottomBar.jsp" />
	 </div>
</body>
</html>