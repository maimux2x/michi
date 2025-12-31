require 'rails_helper'

RSpec.describe 'Admin::Posts', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe '投稿一覧' do
    it '投稿一覧が表示される' do
      post = create(:post, user: user)

      visit admin_root_path

      expect(page).to have_content(post.title)
    end
  end

  describe '投稿作成' do
    it '新規投稿を作成できる' do
      visit new_admin_post_path

      fill_in 'タイトル', with: 'テスト投稿'
      fill_in '本文', with: 'これはテスト本文です。'
      click_button '保存'

      expect(page).to have_current_path(admin_root_path)
      expect(page).to have_content('テスト投稿')
    end
  end

  describe '投稿編集' do
    it '既存の投稿を編集できる' do
      post = create(:post, user: user, title: '元のタイトル')

      visit edit_admin_post_path(post)

      fill_in 'タイトル', with: '更新後のタイトル'
      click_button '保存'

      expect(page).to have_current_path(admin_root_path)
      expect(page).to have_content('更新後のタイトル')
    end
  end

  describe '投稿削除' do
    it '投稿を削除できる' do
      create :post, user: user, title: '削除する投稿'

      visit admin_root_path

      expect(page).to have_content('削除する投稿')

      click_link '削除'

      expect(page).to have_current_path(admin_root_path)
      expect(page).not_to have_content('削除する投稿')
    end
  end
end
