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
  ).on("ajax:error", (evt, xhr, status) ->
    $("#notice-area")
      .addClass("alert-danger")
      .empty()
      .append("<span>Fail to post your comment</span>")
      .append('<button class="close" data-dismiss="alert">&times;</button>')
      .show(300)
  )

  add_tag_or_submit = (e) ->
    field = $("#tag-comp-val")
    if field.val() == ""
      true
    else
      $(".item_tag_names").find(".controls").append(
        $("""<label class="checkbox">
          <input checked="checked" class="check_boxes optional" name="item[tag_names][]" type="checkbox" value="#{field.val()}">#{field.val()}
          </label>
          """)
      )
      field.val("")
      false

  $(".edit_item").submit(add_tag_or_submit)
  $("#tag-comp-btn").click(add_tag_or_submit)

  $(".controls").find("input[type=checkbox]").each (i, dom) ->
    $(dom).change (e) ->
      unless this.checked
        $(this).parent("label").remove()

)(jQuery)
