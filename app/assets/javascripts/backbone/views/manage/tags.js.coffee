Yuetai.Views.Manage ||= {}

class Yuetai.Views.Manage.TagsView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'click .tag-edit' : 'editTag'
    'click .tag-remove' : 'removeTag'
    'click .tag-save' : 'saveTag'
    'click .add-tag' : 'toggleAddTag'
    'submit .header-nav-right-popup form' : 'createTag'

  render: ->
    @$el.html(_.template($('#t-manage-tags').html())())
    $('.tags-nav').addClass('active').siblings().removeClass('active')
    @tags = new Yuetai.Collections.Tags
    @fetchTags()

  renderPagination: ()->
    paginator = new Paginator(
      collection: @tags
    )
    $("#paginator").append(paginator.render().$el)

  toggleAddTag: ->
    $('.header-nav-right-popup').toggle()

  editTag: ->

  removeTag: ->

  saveTag: ->

  fetchTags: ->
    @tags.fetch
      success: =>
        @renderTags()
        @renderPagination()

  renderTags: ->
    @tags.each (tag, i)=>
      @renderTag tag, i

  renderTag: (tag, i, isForward)->
    html = _.template($('#t-manage-tag').html()) _.extend(tag.toJSON(), {index: i + 1})
    if isForward
      $(@el).find('tbody').prepend html
    else
      $(@el).find('tbody').append html

  createTag: (e)->
    e.preventDefault()
    value = $(e.currentTarget).find('[name=name]').val()
    if !value then return
    data = {
      name: value
      newbl: $(e.currentTarget).find('#newbl').val()
    }
    @tags.create data,
      success: (tag)=>
        @renderTag(tag, @tags.length - 1, true)
        @toggleAddTag()
        $(e.currentTarget).find('[name=name]').val('')

  deleteTag: ->

