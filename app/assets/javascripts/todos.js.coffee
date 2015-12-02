# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->
    pressed = false
    todo_id = null

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
                $('#todo_priority').on 'change', showRangeVal
                showRangeVal
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
                $('ul#todos li:last').on 'click', (e) ->
                    if pressed
                        $('#formarea').html ''
                        viewTodo e
                        return
                    else
                        pressed = true
                        $('#formarea').html ''
                        viewTodo e
                        return
                return
            error: (xhr, status, error) ->
                alert "AJAX Error: #{status} ; #{error}"
                return
        return

    viewTodo = (e) ->
        todo_id = $(e.target).attr('id').replace(/todo_/, '')
        $.ajax
            method: "GET"
            url: "todos/#{todo_id}/edit"
            accepts: html: 'text/html'
            success: (data, status, xhr) ->
                $('#formarea').append data.trim()
                $('#formarea').show()
                $('form.edit_todo').on 'submit', formUpdate
                $('.field').val 'Exit'
                $('#todo_priority').on 'change', showRangeVal
                showRangeVal
                return
            error: (xhr, status, error) ->
                alert "AJAX Error: #{status} ; #{error}"
                return
        return false

    formUpdate = (e) ->
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
            method: "PUT"
            url: "todos/#{todo_id}"
            data: data
            accepts: html: 'text/html'
            success: (data, status, xhr) ->
                new_html = $('#todos').html().replace data.trim(), ''
                $('#todos').html new_html
                $('#todos').append data.trim()
                $('#formarea').html ''
                $('.field').val 'New'
                $('#formarea').hide()
                todo_id = null
                $('ul#todos li:last').on 'click', (e) ->
                    if pressed
                        $('#formarea').html ''
                        viewTodo e
                        return
                    else
                        pressed = true
                        $('#formarea').html ''
                        viewTodo e
                        return
                return
            error: (xhr, status, error) ->
                alert "AJAX Error: #{status} ; #{error}"
                return
        return false

    showRangeVal = ->
        $('.numfldval').children().first().text $('#todo_priority').val()
        return

    $('ul#todos li').on 'click', (e) ->
        if pressed
            $('#formarea').html ''
            viewTodo e
            return
        else
            pressed = true
            $('#formarea').html ''
            viewTodo e
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
