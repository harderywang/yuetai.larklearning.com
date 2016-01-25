Yuetai.Views.Manage ||= {}

class Yuetai.Views.Manage.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .tag-edit' : 'editTag'
    'click .tag-remove' : 'removeTag'
    'click .tag-save' : 'saveTag'

  render: ->
    @$el.html(_.template($('#t-manage-show').html())())
    @tags = new Yuetai.Collections.Tags
    @fetchTags()

  editTag: ->

  removeTag: ->

  saveTag: ->

  fetchTags: ->
    @tags.fetch
      success: =>
        @renderTags()

  renderTags: ->
    @tags.each @renderTag, @

  renderTag: (tag)->
    html = _.template($('#t-manage-tag').html()) tag.toJSON()
    $(@el).find('tbody').append html

  createTag: ->

  deleteTag: ->

