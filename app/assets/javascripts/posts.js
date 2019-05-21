// コメント編集ボタンを押した時のボタンアクション
function editComment(comment_id) { // eslint-disable-line
  var comment_area = $('#comment-edit' + comment_id);
  comment_area.removeClass('hidden');

  var comment_display = $('#comment-content' + comment_id);
  comment_display.addClass('hidden');
}

// コメント編集キャンセルボタンを押した時のボタンアクション
function closeComment(comment_id) { // eslint-disable-line
  var comment_area = $('#comment-edit' + comment_id);
  comment_area.addClass('hidden');

  var comment_display = $('#comment-content' + comment_id);
  comment_display.removeClass('hidden');
}
