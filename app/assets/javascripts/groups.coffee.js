var user_ids = [];

function load_users(selected_users_json) {
  var selected_users = JSON.parse(selected_users_json);

  for (var i = 0; i < selected_users.length; i++) {
    var selected_users_html = $("#selected_users").html();

    selected_users_html += $("#user_div_" + selected_users[i].id)[0].outerHTML;

    $("#user_div_"+selected_users[i].id).remove();

    $("#selected_users").html(selected_users_html);

    user_ids.push(String(selected_users[i].id));
  }

  $("#user_ids").val(user_ids);

}

function select_user(user) {
  if($("#user_div_"+$(user).val()).parent()[0].id === "users"){
    var selected_users_html = $("#selected_users").html();

    selected_users_html += $("#user_div_"+$(user).val())[0].outerHTML;

    $("#user_div_"+$(user).val()).remove();

    $("#selected_users").html(selected_users_html);

    user_ids.push($(user).val());
  }
  else {
    var users_html = $("#users").html();

    users_html += $("#user_div_"+$(user).val())[0].outerHTML;

    $("#user_div_"+$(user).val()).remove();

    $("#users").html(users_html);

    var index = user_ids.indexOf($(user).val());

    if (index > -1) {
      user_ids.splice(index, 1);
    }
  }

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
