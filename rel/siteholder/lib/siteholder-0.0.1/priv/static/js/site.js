var host;

$(document).ready(function(){
  
  host = window.location.hostname;

  console.log('host: ' + host);
  
  $('.host-header').html(host);
  
});