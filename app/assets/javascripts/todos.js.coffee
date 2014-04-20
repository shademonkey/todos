# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  window.only_uncompleted = true

  $('.fa-plus').click ->
    $(".list-group").find(".active").each ->
      active = $(this)
      active.removeClass "active"
      active.find(".info").show()
      active.find(".form").hide()
    $(".todo-clone").clone().removeClass("todo-clone").prependTo(".list-group")
      .find(".info").css("display","none")

  $('.list-group').on "click", ".submit", (e) ->
    parent = $(e.currentTarget).parent().parent().parent()
    id = parent.data("id")
    title = parent.find(".title").val()
    description = parent.find(".description").val()

    if title.length == 0
      title = "No title"

    if description.length == 0
      description = "No description"

    parent.find(".list-group-item-heading").html(title)
    parent.find(".list-group-item-text").html(description)

    outgoing_data = { todo: {} }
    outgoing_data["todo"]["title"] = title
    outgoing_data["todo"]["description"] = description

    if !id
      outgoing_data["_method"] = "post"
      $.post("/todos", outgoing_data, (data) =>
        parent.data("id",data.id)
        parent.find(".form").hide()
        parent.find(".info").show()
        parent.removeClass("active")
      ).fail( (data) =>
        parent.find(".errors").show().html("").html("There was an error processing your request")
      )
    else
      outgoing_data["_method"] = "put"
      $.post("/todos/" + id, outgoing_data, () =>
        parent.find(".form").hide()
        parent.find(".info").show()
        parent.removeClass("active")
      ).fail( (data) =>
        parent.find(".errors").show().html("").html("There was an error processing your request")
      )

  $('.list-group').on "click", ".delete", (e) ->
    if confirm("Are you sure you want to delete this todo?")
      parent = $(e.currentTarget).parent().parent()
      id = parent.data("id")
      $.post("/todos/" + id, { "_method" : "delete" }, =>
        parent.remove()
      )

  $('.list-group').on "click", ".edit", (e) ->
    $(".list-group").find(".active").each ->
      active = $(this)
      if active.data("id")
        active.removeClass "active"
        active.find(".info").show()
        active.find(".form").hide()
      else
        active.remove()

    parent = $(e.currentTarget).parent().parent()
    parent.find(".info").hide()
    parent.find(".form").show()
    parent.addClass("active")

  $('.list-group').on "click", ".cancel", (e) ->
    parent = $(e.currentTarget).parent().parent().parent()
    if parent.data("id")
      parent.removeClass("active")
      parent.find(".info").show()
      parent.find(".form").hide()
    else
      parent.remove()

  $('.list-group').on "click", ".fa-square-o", (e) ->
    parent = $(e.currentTarget).parent().parent()
    id = parent.data("id")
    $.post("/todos/" + id, { "_method" : "put", todo: { completed: true } }, =>
      console.log e
      $(e.currentTarget).removeClass("fa-square-o").addClass("fa-check-square-o")
      window.filter()
    )

  $('.list-group').on "click", ".fa-check-square-o", (e) ->
    parent = $(e.currentTarget).parent().parent()
    id = parent.data("id")
    $.post("/todos/" + id, { "_method" : "put", todo: { completed: false } }, =>
      $(e.currentTarget).removeClass("fa-check-square-o").addClass("fa-square-o")
      window.filter()
    )

  $(".filter").click ->
    if (window.only_uncompleted)
      window.only_uncompleted = false
      filter()
      $(this).html("Show only uncompleted")
    else
      window.only_uncompleted = true
      $(this).html("Show all")
      filter()

  window.filter = ->
    if window.only_uncompleted
      $(".fa-check-square-o").each ->
        $(this).parent().parent().hide()
    else
      $(".fa-check-square-o").each ->
        $(this).parent().parent().show()

  window.filter()
