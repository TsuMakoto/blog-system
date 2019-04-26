Rails.application.routes.draw do
  # 新規投稿画面
  get 'posts/new' => 'posts#edit'

  # topページ表示
  get '/' => 'home#top'
end
