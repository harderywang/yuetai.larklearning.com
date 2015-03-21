Yuetai.Views.Blogs ||= {}

class Yuetai.Views.Blogs.EditView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    'submit #edit-blog-form' : 'updateBlog'
    'click .cancel' : 'navBack'

  render: ->
    # @rm_nav()
    # @clearMsg()
    # @render_nav(@opts.section)
    @blog = new Yuetai.Models.Blog(id: @opts.blog_id)
    @fetchBlog()

  fetchBlog: ->
    @blog.fetch(
      success: =>
        console.log @blog
        @$el.html(_.template($('#t-blog-edit').html())(blog: @blog.toJSON()))
    )

  updateBlog: (e)->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    data.title = @$(e.currentTarget).find('#blog-title').val()
    data.body = @$(e.currentTarget).find('#blog-body').val()
    data.tag_id = @$(e.currentTarget).find('#blog-tag').val()
    data.user_id = @account.id
    data.template = 'blog'
    @blog.save(data,
                  success: ->
                    window.location.href = '#blogs'
    )