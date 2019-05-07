Rails.application.routes.draw do
  devise_for :users
  # 新規投稿画面
  get 'posts/:id/new' => 'posts#new'
  # 投稿編集画面
  get 'posts/:id/edit' => 'post#edit'
  # 投稿一覧表示
  get 'posts/:id/show' => 'posts#show'
  post 'posts/:id/create' => 'posts#create'
  # 記事更新
  post 'pos投稿ts/:id/update' => 'posts#update'

  # topページ表示
  get '/' => 'home#top'
end
