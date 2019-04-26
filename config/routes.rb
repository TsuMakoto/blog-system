Rails.application.routes.draw do
  # 新規投稿画面追加
  get 'posts/new' => 'posts#new'

  # topページ表示
  get '/' => 'home#top'
end
