React        = require 'react'
ArticleStore = require '../../stores/article_store.coffee'
CourseUtils  = require('../../utils/course_utils.js').default

userLink = (username) ->
  <a key={username} href="https://en.wikipedia.org/wiki/User:#{username}">{username}</a>

Assignment = React.createClass(
  displayName: 'Assignment'
  render: ->
    article = @props.article || CourseUtils.articleFromAssignment(@props.assign_group[0])

    unless article.formatted_title
      article.formatted_title = CourseUtils.formattedArticleTitle(
        @props.assign_group[0].language,
        @props.assign_group[0].project,
        article.title
      )

    className = 'assignment'
    ratingClass = 'rating ' + article.rating
    ratingMobileClass = ratingClass + ' tablet-only'
    articleLink = <a onClick={@stop} href={article.url} target="_blank" className="inline">{article.formatted_title}</a>

    assignees = []
    reviewers = []
    for assignment in _.sortBy @props.assign_group, 'username'
      if assignment.role == 0
        assignees.push userLink(assignment.username)
        assignees.push ', '
      else if assignment.role == 1
        reviewers.push userLink(assignment.username)
        reviewers.push ', '

    assignees.pop() if assignees.length
    reviewers.pop() if reviewers.length

    <tr className={className}>
      <td className='tooltip-trigger desktop-only-tc'>
        <p className="rating_num hidden">{article.rating_num}</p>
        <div className={ratingClass}><p>{article.pretty_rating || '-'}</p></div>
        <div className="tooltip dark">
          <p>{I18n.t('articles.rating_docs.' + (article.rating || '?'))}</p>
        </div>
      </td>
      <td>
        <div className={ratingMobileClass}><p>{article.pretty_rating}</p></div>
        <p className="title">
          {articleLink}
        </p>
      </td>
      <td className='desktop-only-tc'>{assignees}</td>
      <td className='desktop-only-tc'>{reviewers}</td>
      <td></td>
    </tr>
)

module.exports = Assignment
