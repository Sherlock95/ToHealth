# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->
    pressed = false

    newAjax = ->
        $.ajax
            method: 'GET'
            url: 'todos/new'
            accepts: html: 'text/html'
            success: (data, status, xhr) ->
                $('#formarea').append data.trim()
                $('#formarea').show()
                $('.field').val 'Exit'
                $('#new_todo').on 'submit', formSubmit
                return
            error: (xhr, status, error) ->
                alert "AJAX Error: #{status} ; #{error}"
                return
        return

    hideForm = ->
        $('#formarea').html ''
        $('.field').val 'New'
        $('#formarea').hide()
        return

    formSubmit = ( e ) ->
        e.preventDefault()
        data = {
            'name': $('#todo_name').val(),
            'course': $('#todo_course').val(),
            'dueDate': $('#todo_dueDate').val(),
            'estTime': $('#todo_estTime').val(),
            'description': $('#todo_description').val(),
            'priority': $('#todo_priority').val()
        }
        $.ajax
            method: "POST"
            url: "todos/create"
            data: data
            accepts: html: 'text/html'
            success: (data, status, xhr) ->
                $('#todos').append data.trim()
                $('#formarea').html ''
                $('.field').val 'New'
                $('#formarea').hide()
                pressed = false
                return
            error: (xhr, status, error) ->
                alert "AJAX Error: #{status} ; #{error}"
                return
        return
    
    bindAjax = ->
        $('ul.todos').append data
        alert status
        hideForm()
        pressed = false
        return

    $('.field').on 'click', (e) ->
        if pressed
            pressed = false
            hideForm()
            return
        else
            pressed = true
            newAjax()
        return
    return
