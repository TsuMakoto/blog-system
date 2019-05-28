Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :passwords => 'users/passwords',
    :sessions => 'users/sessions'
  }
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  # 記事投稿に関するrouting
  resources :posts do
    # 記事に紐づくコメント
    resources :comments,  only: [:create, :destroy, :update]
    # ajaxによる記事のタイトル検索
    get :ajax_posts, only: [:index], on: :collection
  end

  # ユーザ
  resources :users, only: [:show] do
    # ajaxによる記事のタイトル検索
    get :ajax_posts
    # ユーザに紐づく記事一覧
    resources :posts, only: [:index], module: :users
  end

  get '/' => 'home#top', as: :top
end
