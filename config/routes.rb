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
  
  # 記事投稿に関するrouting
  resource :posts, except: [:index, :destroy, :show]
  # 記事削除
  post 'posts/:post_id/destroy' => 'posts#destroy'
  # 自分の記事一覧を表示
  get ':user_id/posts/show' => 'posts#myposts'
  # 記事更新
  patch 'posts/:post_id/update' => 'posts#update'
  # 記事表示
  get 'posts/:post_id/detail' => 'posts#detail'



  # コメント新規投稿
  post 'comment/:post_id/new' => 'comment#new'
# コメント削除
  post 'comment/:comment_id/destroy' => 'comment#destroy'
  # コメント編集
  post 'comment/:comment_id/update' => 'comment#update'

  # カテゴリー一覧表示
  # TODO: カテゴリー付けをする機能をつける
  # get 'category/all' => 'category#all'
  # カテゴリーの追加
  # post 'category/new' => 'category#new'

  # ユーザのホーム画面表示
  get '/:user_id' => 'home#user'
  # トップの表示
  get '/' => 'home#top'

end
