Rails.application.routes.draw do
  devise_for :users
  # 新規投稿画面
  get 'posts/new' => 'posts#edit'

  # topページ表示
  get '/' => 'home#top'
end
