$(document).ready(function(){
  setInterval(renderSensor,1000);
});

function renderSensor(){
  $.ajax('/local_data_objects/latest').done(function(response){
    $('#sensor').html(response.reading);
  });
}
