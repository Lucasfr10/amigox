var user_ids = [];

function verify_even_users(){
  if(user_ids.length > 0 && user_ids.length % 2 == 0){
    $("#save_event").prop( "disabled", false );
    $("#save_event_label").html("&nbsp;");
  }
  else {
    $("#save_event").prop( "disabled", true );
    $("#save_event_label").html("Necessário um número par de participantes.")
  }
}

function load_users(selected_users_json) {
  var selected_users = JSON.parse(selected_users_json);

  for (var i = 0; i < selected_users.length; i++) {
    select_user(selected_users[i].id)
  }
}

function select_user(user) {
  if($("#user_div_"+user).parent()[0].id === "users"){
    var selected_users_html = $("#selected_users").html();

    selected_users_html += $("#user_div_"+user)[0].outerHTML;

    $("#user_div_"+user).remove();

    $("#selected_users").html(selected_users_html);

    user_ids.push(user);
  }
  else {
    var users_html = $("#users").html();

    users_html += $("#user_div_"+user)[0].outerHTML;

    $("#user_div_"+user).remove();

    $("#users").html(users_html);

    var index = user_ids.indexOf(user);

    if (index > -1) {
      user_ids.splice(index, 1);
    }
  }

  verify_even_users();

  $("#user_ids").val(jQuery.unique(user_ids));
}

function search_user(value) {
  value = value.toLowerCase();

  var users = $("#users").children("[name=user]");

  for (var i = 0; i < users.length; i++) {
    $(users[i]).hide();

    var name = $($(users[i]).find("#name")[0]).html().toLowerCase();
    var email = $($(users[i]).find("#email")[0]).html().toLowerCase();

    if (name.includes(value) || email.includes(value)) {
      $(users[i]).show();
    }
  }
}
