Rails.application.routes.draw do

  get 'comment/new'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # 新規投稿画面
  get 'posts/new' => 'posts#new'
  # 投稿編集画面
  get 'posts/:post_id/edit' => 'posts#edit'
  # 記事削除
  post 'posts/:post_id/destroy' => 'posts#destroy'
  # 自分の記事一覧を表示
  get ':user_id/posts/show' => 'posts#myposts'
  # 投稿一覧表示
  get 'posts/show' => 'posts#show'
  # 記事作成
  post 'posts/create' => 'posts#create'
  # 記事更新
  post 'posts/:post_id/update' => 'posts#update'
  # 記事表示
  get 'posts/:post_id/detail' => 'posts#detail'

  # コメント新規投稿
  post 'comment/:post_id/new' => 'comment#new'
# コメント削除
  post 'comment/:comment_id/destroy' => 'comment#destroy'

  # カテゴリー一覧表示
  get 'overall/category' => 'overall#category'
  # カテゴリーの追加
  post 'overall/category/new' => 'overall#new_cate'

  # ユーザのホーム画面表示
  get '/:user_id' => 'home#user'
  # トップの表示
  get '/' => 'home#top'

end
