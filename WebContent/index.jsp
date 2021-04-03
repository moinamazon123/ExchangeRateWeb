<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exchange Rate</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body>

<h2 align="center">Welcome to Currency Convert Web</h2> <h5 align="right" ><a href="" data-toggle="modal" data-target="#aboutModal">About</a></h5>

<table style="text-align: center;" class="table" border="0">

<tr><td><a href="exchange.jsp?flag=list">List of Currencies</a></td></tr>
<tr><td><a href="exchange.jsp?flag=convert">Convert Currency</a></td></tr>
<tr><td><a href="exchange.jsp?flag=convertUnit">Convert Unit Currency</a></td></tr>
<tr><td><a href="exchange.jsp?flag=hits">Get Currency Hits</a></td></tr>
<tr><td><a href="exchange.jsp?flag=trend">Get Trend</a></td></tr>

</table>



<!-- Modal -->
<div class="modal fade" id="aboutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">About Developer</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        This Project is Developed by Moin. Contact  <a href="mailto:moinamazon123@gmail.com">Moin</a>.<br><br/>
        Powered By :
        <table>
        <tr><td><img height="5%" width="80%" src="images/boot.png"></td>
        <td><img height="5%" width="80%" src="images/canvas.png"></td>
         <td><img height="5%" width="80%" src="images/jquery.png"></td>
          <td><img height="5%" width="80%" src="images/sb.png"></td>
          
        </tr>
        
        </table>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
   
      </div>
    </div>
  </div>
</div>

</body>
</html>