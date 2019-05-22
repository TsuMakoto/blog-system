module Common
  extend ActiveSupport::Concern
  # モデルのセーブを実行し,指定のURLへリダイレクト
  # @param [String] redirect_url : リダイレクト先URL
  # @param [String] render_url : モデルの保存に失敗した時のレンダー先
  # @param [ApplicationRecord] model : 保存したいモデル
  # @param [String] success_message : 成功メッセージ
  def model_save_and_redirect(redirect_url, render_url, model, success_message)
    if model.save
      redirect_to(redirect_url, notice: success_message)
    else
      render(render_url)
    end
  end

  # モデルのセーブを実行し,指定のURLへリダイレクト
  # @param [String] redirect_url : リダイレクト先URL
  # @param [String] render_url : モデルの保存に失敗した時のレンダー先
  # @param [ApplicationRecord] model : 保存したいモデル
  # @param [Array] target_params : 更新させたい配列
  # @param [String] success_message : 成功メッセージ
  def model_update_and_redirect(redirect_url, render_url, model, target_params, success_message)
    if model.update(target_params)
      redirect_to(redirect_url, notice: success_message)
    else
      render(render_url)
    end
  end

  # モデルの削除を実行し,指定のURLへリダイレクト
  # @param [String] redirect_url : リダイレクト先URL
  # @param [String] render_url : モデルの保存に失敗した時のレンダー先
  # @param [ApplicationRecord] model : 削除したいモデル
  # @param [String] success_message : 成功メッセージ
  def model_destroy_and_redirect(redirect_url, render_url, model, success_message)
    if model.destroy
      redirect_to(redirect_url, notice: success_message)
    else
      # render(render_url)
      redirect_to(render_url)
    end
  end

  # modelを指定分だけ日付のオーダーで取得する
  # params [Symbol] arrange: :desc or :asc
  # params [integer] number_in_one_page: 一ページの表示数
  # params [array] page_params: pagination対象のパラメータ
  # params [ApplicationRecord] target_model: 対象のモデル
  def fetch_paginated_model_order_date(arrange, number_in_one_page, page_params, target_model)
    target_model.order(created_at: arrange).page(page_params).per(number_in_one_page)
  end

  def setting_shared_column(val:)
    Settings.shared[val]
  end

  def setting_model_column(model:, action:, val:)
    Settings[model][action][val]
  end
end
