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

// ajaxによる非同期通信用変数を定義
var preFunc = null, preInput = '';
function ajaxPost (input) {
  $.ajax({
    url: `${location.pathname}/ajax_posts`,
    type: 'GET',
    data: ('word=' + input)
  });
}

// incremental searchを行う
function incrementalSearch(input) {
  // 前回の検索単語と比較
  if(preInput !== input){
    clearTimeout(preFunc);
    preFunc = setTimeout(ajaxPost(input), 500);
  }
  preInput = input;
}

// タイトル検索領域でキーが離れた瞬間のイベントを定義
$(document).on('keyup', '#increment-title-search', function () {
  // 空白の削除
  incrementalSearch($.trim($(this).val()));
});

