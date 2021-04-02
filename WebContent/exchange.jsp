<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exchange <%=request.getParameter("flag") %></title>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
 

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
 <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">


</head>
<body>
<a href="index.jsp">Back</a>
<% if(request.getParameter("flag")!=null && request.getParameter("flag").equals("list")) { %>

<h2 align="center">List of Currencies : <b><div id="total"></div></b> </h2>
 
 <table style="text-align: center;" class="table" id="table"><div id="loading">Loading...</div></table>
 
 <%} %>
 
 <% if(request.getParameter("flag")!=null && request.getParameter("flag").equals("convert")) { %>

<h2 align="center">Convert Currency Rates</h2> 
<table style="text-align: center;" class="table">

<tr><td>Enter the Source Currency</td>
<td><select  id="mySrcCurrencies"></select></td></tr>

<tr><td>Enter the Target Currency</td>
<td><select  id="myTrgtCurrencies"></select></td></tr>

<tr><td><input  type="button" class="btn btn-primary" id="convert" value="Convert"></td></tr>
<tr><td><div id="result"></div></td></tr>
<div id="error"></div>
</table>

 
 <%} %>
 
  <% if(request.getParameter("flag")!=null && request.getParameter("flag").equals("convertUnit")) { %>

<h2 align="center">Convert Unit Currency Rates</h2> 
<table style="text-align: center;" class="table">

<tr><td>Enter the Source Currency</td>
<td><select  id="mySrcCurrencies"></select>&nbsp; </td></tr>

<tr><td>Unit : </td><td><input id="unit" type="text"></td></tr>

<tr><td>Enter the Target Currency</td>
<td><select  id="myTrgtCurrencies"></select></td></tr>

<tr><td><input type="button" class="btn btn-primary" id="convertUnit" value="Convert Unit"></td></tr>
<tr><td><div id="result"></div></td></tr>
<div id="error"></div>
</table>

 
 <%} %>
 
   <% if(request.getParameter("flag")!=null && request.getParameter("flag").equals("hits")) { %>
   <h2 align="center">Convert  Currency Hits</h2> 

<table style="text-align: center;" class="table">

<tr><td>Enter the Source Currency</td>
<td><select  id="mySrcCurrencies"></select></td></tr>



<tr><td><input type="button" class="btn btn-primary" id="gethits" value="Get Hits"></td></tr>
<tr><td><div id="result"></div></td></tr>
<div id="error"></div>
</table>

 
 <%} %>
  <% if(request.getParameter("flag")!=null && request.getParameter("flag").equals("trend")) { %>
 
 <h2 align="center">Rate Analysis</h2> 

<table style="text-align: center;" class="table">

<tr><td>Enter the From date</td>
<td><input type="date" id="fromDate"></td></tr>
<tr><td>Enter the To date</td>
<td><input type="date" id="toDate"></td></tr>

<tr><td>Enter Currency:</td><td><select  id="mySrcCurrencies"></select></td></tr>



<tr><td><input type="button" class="btn btn-primary" id="getrend" value="Get Trend"></td></tr>

<div id="error"></div>
</table>
 
 <div id="chartContainer" style="height: 300px; width: 100%;"></div>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 


 
 <%} %>
 
 <script>
 
 $(document).ready(function () {
	 $("#loading").show();
	 
$("#getrend").click(function(){
	
console.log($("#fromDate").val(),$("#toDate").val())


 $("#getrend").val("Loading...");
	        	 $.ajax({
	 	            type: "GET",
	 	            url: "http://localhost:7070/api/rates/getCurrencyTrend/"+ $("#mySrcCurrencies").val()+"/"+$("#fromDate").val()+"/"+$("#toDate").val(),
	 	            contentType: "application/json;charset=utf-8",
	 	            datatype: "json",
	 	            success: function(response) {
	 	            	 $("#error").hide();
	 	            	 $("#getrend").val("Submit");
	 	            	 var data = [];
	 	           	 var dataSeries = { type: "line" };
	 	       	 var dataPoints = [];
	                     console.log("response:" , response);
	                     
	                     $("#result").text("Result: "+response);
	                     
	                     $.each(response, function(e,k) {
	                    	 dataPoints.push({ x: new Date(k.date.split("-")[0], Number(k.date.split("-")[1])-1,k.date.split("-")[2]), y: k.rate });
	                    	
	                 	 });
	                 	 dataSeries.dataPoints = dataPoints;
	                 	data.push(dataSeries);
	                 	 console.log(data);
	                 	 //Better to construct options first and then pass it as a parameter
	                	 var options = {
	                	 	zoomEnabled: true,
	                	 	animationEnabled: true,
	                	 	title: {
	                	 		text: "Euro To "+$("#mySrcCurrencies").val()+" Rates from :"+$("#fromDate").val()+" to :"+$("#toDate").val()
	                	 	},
	                	 	data: data  // random data
	                	 };

	                	 $("#chartContainer").CanvasJSChart(options);
	                
	                 },
	                 error: function(jqXHR, textStatus, errorThrown) {
	                	 $("#getrend").val("Submit");
	                	 $("#error").show();
	                	 $("#error").html("<font color=red>"+jqXHR.responseText+"</font>")
	                     console.log(' Error in processing!',jqXHR.responseText);

	                 }
	 	         });


	

});
	 

	 
	        $.ajax({
	            type: "GET",
	            url: "http://localhost:7070/api/rates/getList",
	           // data: "{ ID:'" + $(this).val()+ "'}",
	            contentType: "application/json;charset=utf-8",
	            datatype: "json",
	            success: function(data) {
                    console.log("response:" + data);
                    $("#list").html(data);
                    $("#loading").hide();
                    var elements = data.toString().split(",");
                    $("#total").text("Total " +elements.length);
                    
                    console.log(elements);
                    $.each(elements, function(e,k) {
                    	   var row='<tr class="thead-dark">';
                    	   
                    	  // row+='<td>'+e+'</td>';
                    	      row+='<td> '+k+'</td>';
                    	  
                    	   row+='</tr>';
                    	   $('#table').append(row);
                    	})
                    	var mysrcCurrencies = $('#mySrcCurrencies');
                    mysrcCurrencies.append( $('<option></option>').val("selsrc").html("--Select Source Currency--"));
                    $.each(elements, function(val, text) {
                    	
                    	mysrcCurrencies.append(
                            $('<option></option>').val(text).html(text)
                        );
                    });
                	var myTrgtCurrencies = $('#myTrgtCurrencies');
                	myTrgtCurrencies.append( $('<option></option>').val("seltrgt").html("--Select Target Currency--"));
                    $.each(elements, function(val, text) {
                    	
                    	myTrgtCurrencies.append(
                            $('<option></option>').val(text).html(text)
                        );
                    });
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(' Error in processing!');

                }
	         });
	    
	        
	        $("#convert").click(function(){
	        	
	        	if($("#mySrcCurrencies").val() == $("#myTrgtCurrencies").val() ){
	        		 $("#error").show();
                	 $("#error").html("<div align='center' class='alert alert-danger'> Source and Target Currency Can't be same</div>");
	        	} else {
	        	
	        	 $("#convert").val("Loading...");
	        	 $.ajax({
	 	            type: "GET",
	 	            url: "http://localhost:7070/api/rates/convertCurrency/from/"+ $("#mySrcCurrencies").val()+"/to/"+$("#myTrgtCurrencies").val(),
	 	            contentType: "application/json;charset=utf-8",
	 	            datatype: "json",
	 	            success: function(data) {
	 	            	 $("#error").hide();
	 	            	 $("#convert").val("Submit");
	                     console.log("response:" + data);
	                     
	                     $("#result").text("Result: "+data);
	                
	                 },
	                 error: function(jqXHR, textStatus, errorThrown) {
	                	 $("#convert").val("Submit");
	                	 $("#error").show();
	                	 $("#error").html("<font color=red>"+jqXHR.responseText+"</font>")
	                     console.log(' Error in processing!',jqXHR.responseText);

	                 }
	 	         });
	        	
	        	}
	        	
	        })
	        
	         $("#convertUnit").click(function(){
	        	 
	        	 if($("#mySrcCurrencies").val() == $("#myTrgtCurrencies").val() ){
	        		 $("#error").show();
                	 $("#error").html("<div align='center' class='alert alert-danger'> Source and Target Currency Can't be same</div>");
	        	} else {
	        	
	        	 $("#convertUnit").val("Loading...");
	        	 $.ajax({
	 	            type: "GET",
	 	            url: "http://localhost:7070/api/rates/convertCurrencyUnits/from/"+ $("#mySrcCurrencies").val()+"/"+$("#unit").val()+"/to/"+$("#myTrgtCurrencies").val(),
	 	            contentType: "application/json;charset=utf-8",
	 	            datatype: "json",
	 	            success: function(data) {
	 	            	 $("#error").hide();
	 	            	 $("#convertUnit").val("Submit");
	                     console.log("response:" + data);
	                     
	                     $("#result").text("Result: "+data);
	                
	                 },
	                 error: function(jqXHR, textStatus, errorThrown) {
	                	 $("#error").show();
	                	 $("#error").html("<font color=red>"+jqXHR.responseText+"</font>")
	                     console.log(' Error in processing!');

	                 }
	 	         });
	        	
	        	}
	        	
	        })
	        
	            $("#gethits").click(function(){
	        	
	        	 $("#gethits").val("Loading...");
	        	 $.ajax({
	 	            type: "GET",
	 	            url: "http://localhost:7070/api/rates/getConversionHits/"+ $("#mySrcCurrencies").val(),
	 	            contentType: "application/json;charset=utf-8",
	 	            datatype: "json",
	 	            success: function(data) {
	 	            	 $("#gethits").val("Submit");
	 	            	 $("#error").hide();
	                     console.log("response:" + data);
	                     
	                     $("#result").text("Hits: "+data);
	                
	                 },
	                 error: function(jqXHR, textStatus, errorThrown) {
	                	 $("#gethits").val("Submit");
	                	 $("#error").show();
	                	 $("#error").html("<font color=red>"+jqXHR.responseText+"</font>")
	                     console.log(' Error in processing!',jqXHR);

	                 }
	 	         });
	        	
	        	
	        	
	        })
	        
	        
	});
 
 
 
 </script>
   <script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
 

 
</body>
</html>