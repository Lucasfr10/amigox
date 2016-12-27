var chat_refresh_intervalId;
var chat_user_id;
var reciver_id;
var first_chat_load = true;

function get_user(user_id){
  chat_user_id = user_id;

  first_chat_load = true;

  get_messages();

  select_chat_user($("[name=chat_messages]")[0].id.replace("chat_user_messages_", ""));
}

function send_message() {
  message = $("#chat_input_message").val();
  if(message.trim() != ''){
    $.ajax({
      url: "/send_message",
      type: "POST",
      data: {
        chat : {
          sender_id: chat_user_id,
          receiver_id: reciver_id,
          message: message
        }
      }
    });
    $("#chat_input_message").val('');
    get_messages();
  }
}

function get_messages(){
  $.get( "/get_messages/"+chat_user_id, function(data) {
    if($("#chat").length){
      load_messages(data);
    }
    first_chat_load = false;
  });
}

function load_messages(messages){
  for (var i = 0; i < messages.length; i++) {
    var message = messages[i];

    if (message.sender_id == chat_user_id) {
      $("#chat_user_messages_" + message.receiver_id).append(self_message(message));
    }
    else {
      $("#chat_user_messages_" + message.sender_id).append(someone_else_message(message));
    }
  }
}

function self_message(message) {
  var msg_html = '';

  if(!$("#message_"+ message.id).length){
    msg_html = ''+
    '<div class="row" id="message_'+ message.id +'">'+
      '<div class="col-md-7 col-md-offset-5 chat-sent-msg">'+
        message.message +
      '</div>'+
    '</div>'+
    '<br>';

    if (first_chat_load == false ) {
      var $target = $("#chat_user_messages_" + message.receiver_id);
      $target.animate({scrollTop: $target.height()}, 500);
    }
  }

  return msg_html;
}

function someone_else_message(message) {
  var msg_html = '';

  if(!$("#message_"+ message.id).length){
    console.log(first_chat_load);

    msg_html = ''+
    '<div class="row" id="message_'+ message.id +'">'+
      '<div class="col-md-7 chat-received-msg">'+
        message.message+
      '</div>'+
    '</div>'+
    '<br>';

    if (first_chat_load == false ) {
      var audio = new Audio('/assets/notification_sound.ogg');
      audio.play();

      var $target = $("#chat_user_messages_" + message.sender_id);
      $target.animate({scrollTop: $target.height()}, 1000);
    }
  }

  return msg_html;
}

function select_chat_user(user_id) {
  $("[name=chat_messages]").hide();
  $("[name=chat-user]").removeClass("chat-active-user");

  $("#chat_user_messages_" + user_id).show();
  $("#chat_user_" + user_id).addClass("chat-active-user");

  var $target = $("#chat_user_messages_" + user_id);
  $target.animate({scrollTop: $target.height()}, 1000);

  reciver_id = user_id;
}
