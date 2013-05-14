# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
(($) ->
  $("#new_comment").on("ajax:success", (evt, data, status) ->
    $("#notice-area")
      .addClass("alert-success")
      .empty()
      .append("<span>Success to post your comment</span>")
      .append('<button class="close" data-dismiss="alert">&times;</button>')
      .show(300)
    $("div.comments").append(data)
    $("textarea#comment_content").val("")
  )
)(jQuery)
