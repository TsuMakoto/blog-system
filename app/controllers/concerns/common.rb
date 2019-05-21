module Common
  extend ActiveSupport::Concern
  # モデルのセーブを実行し,指定のURLへリダイレクト
  # ==== Args
  # redirect_url :: リダイレクト先URL
  # render_url :: モデルの保存に失敗した時のレンダー先
  # model :: 保存したいモデル
  # success_message :: 成功メッセージ
  def model_save_and_redirect(redirect_url, render_url, model, success_message)
    if model.save
      redirect_to(redirect_url, notice: success_message)
    else
      render(render_url)
    end
  end

  # モデルのセーブを実行し,指定のURLへリダイレクト
  # ==== Args
  # redirect_url :: リダイレクト先URL
  # render_url :: モデルの保存に失敗した時のレンダー先
  # model :: 保存したいモデル
  # target_params :: 更新対象の配列
  # success_message :: 成功メッセージ
  def model_update_and_redirect(redirect_url, render_url, model, target_params, success_message)
    if model.update(target_params)
      redirect_to(redirect_url, notice: success_message)
    else
      render(render_url)
    end
  end

  # モデルの削除を実行し,指定のURLへリダイレクト
  # ==== Args
  # redirect_url :: リダイレクト先URL
  # render_url :: モデルの削除に失敗した時のレンダー先
  # model :: 削除したいモデル
  # success_message :: 成功メッセージ
  def model_destroy_and_redirect(redirect_url, render_url, model, success_message)
    if model.destroy
      redirect_to(redirect_url, notice: success_message)
    else
      # render(render_url)
      redirect_to(render_url)
    end
  end

end
