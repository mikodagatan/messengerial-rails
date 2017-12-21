$(document).on('turbolinks:load', function() {

  $('#task_client_id').change(function() {
    $.ajax({
       url: "/selections/change_target_client", // this will be routed
       type: 'GET',
       data: {
         send_id: $("#task_client_id").val()
       },
       async: true,
       dataType: "json",
       error: function(XMLHttpRequest, errorTextStatus, error){
                  alert("Failed: "+ errorTextStatus+ " : " + error);
              },
       success: function(data){
          // here we iterate the json result
          $("#task_target_client_id").empty();
          $("#task_target_client_id").append(new Option("", null));
          for(var i in data)
          {
            var id = data[i].id;
            var title = data[i].name;
            $("#task_target_client_id").append(new Option(title, id));
          }
       }
    });
  });

  $('#task_target_client_id').change(function() {
    $.ajax({
       url: "/selections/change_contact_person", // this will be routed
       type: 'GET',
       data: {
         send_id: $("#task_target_client_id").val()
       },
       async: true,
       dataType: "json",
       error: function(XMLHttpRequest, errorTextStatus, error){
                  alert("Failed: "+ errorTextStatus+ " : " + error);
              },
       success: function(data){
          // here we iterate the json result
          $("#task_contact_person_id").empty();
          for(var i in data)
          {
            var id = data[i].id;
            var title = data[i].first_name + " " + data[i].last_name;
            $("#task_contact_person_id").append(new Option(title, id));
          }
       }
    });
  });

  $('#task_target_client_id').change(function() {
    $.ajax({
       url: "/selections/change_address", // this will be routed
       type: 'GET',
       data: {
         send_id: $("#task_target_client_id").val()
       },
       async: true,
       dataType: "json",
       error: function(XMLHttpRequest, errorTextStatus, error){
                  alert("Failed: "+ errorTextStatus+ " : " + error);
              },
       success: function(data){
          // here we iterate the json result
          $("#task_address_id").empty();
          for(var i in data)
          {
            var id = data[i].id;
            var title = data[i].first_line + " " + data[i].second_line;
            $("#task_address_id").append(new Option(title, id));
          }
       }
    });
  });
});
