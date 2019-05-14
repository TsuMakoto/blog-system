Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  # 記事投稿に関するrouting
  resources :posts, param: :post_id

  # コメント投稿に関するrouting
  resources :comment, only: [:destroy, :update], param: :comment_id
  post 'comment/:post_id/new' => 'comment#new'

  # 自分の記事一覧を表示
  get ':user_id/posts/show' => 'posts#myposts'

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
