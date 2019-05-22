Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  # 記事投稿に関するrouting
  resources :posts do
    # 記事に紐づくコメント
    resources :comments,  only: [:create, :destroy, :update]
  end

  # ユーザ
  resources :users, only: [:show] do
    # ユーザに紐づく記事一覧
    resources :posts, only: [:index], module: :users
  end

  get '/' => 'home#top', as: :top

  resources :hoge

# hoge_index GET    /hoge(.:format)                                                                          hoge#index
#           POST   /hoge(.:format)                                                                          hoge#create
#  new_hoge GET    /hoge/new(.:format)                                                                      hoge#new
# edit_hoge GET    /hoge/:id/edit(.:format)                                                                 hoge#edit
#      hoge GET    /hoge/:id(.:format)                                                                      hoge#show
#           PATCH  /hoge/:id(.:format)                                                                      hoge#update
#           PUT    /hoge/:id(.:format)                                                                      hoge#update
#           DELETE /hoge/:id(.:format)                                                                      hoge#destroy

end
