require 'minitest_helper'

class RoutesTest < ActionController::IntegrationTest

  it '/blog' do
    assert_generates '/blog', :controller => 'posts', :action => 'index'
  end

  it '/blog/comments' do
    assert_generates '/blog/comments', :controller => 'comments', :action => 'create'
  end

  it '/home' do
    assert_generates '/home', :controller => 'home', :action => 'index'
  end

  it '/company' do
    assert_generates '/company', :controller => 'company', :action => 'index'
  end

  it '/team' do
    assert_generates '/team', :controller => 'team', :action => 'index'
  end

  it '/team/1' do
    assert_generates '/team/1', {:controller => 'team', :action => 'show', :id => 1}
  end

  it '/projects' do
    assert_generates '/projects', :controller => 'projects', :action => 'index'
  end

  it '/projects/1' do
    assert_generates '/projects/1', {:controller => 'projects', :action => 'show', :id => 1}
  end

  it '/jobs' do
    assert_generates '/jobs', :controller => 'jobs', :action => 'index'
  end

  it '/jobs/1' do
    assert_generates '/jobs/1', {:controller => 'jobs', :action => 'show', :id => 1}
  end

  it '/jobs/create' do
    assert_generates '/jobs', :controller => 'jobs', :action => 'create'
  end

  it '/contact' do
    assert_generates '/contact', :controller => 'contact', :action => 'index'
  end

  it '/contact/create' do
    assert_generates '/contact', :controller => 'contact', :action => 'create'
  end

  it '/admin_chat/chat' do
    assert_generates '/admin_chat/chat', :controller => 'admin_chat', :action => 'chat'
  end

  it '/admin_chat/go_offline' do
    assert_generates '/admin_chat/go_offline', :controller => 'admin_chat', :action => 'go_offline'
  end

  it '/admin/time_online' do
    assert_generates '/admin/time_online', :controller => 'time_onlines', :action => 'set_time'
  end

  it '/comment_load' do
    assert_generates '/comment_load', :controller => 'posts', :action => 'comments_show_all'
  end

  it '/create_chat' do
    assert_generates '/create_chat', :controller => 'live_chats', :action => 'create_chat'
  end

  it '/chat_send_msg' do
    assert_generates '/chat_send_msg', :controller => 'live_chats', :action => 'send_msg'
  end

  it '/new_chat' do
    assert_generates '/new_chat', :controller => 'live_chats', :action => 'new_chat'
  end

  it '/chat_close' do
    assert_generates '/chat_close', :controller => 'live_chats', :action => 'chat_close'
  end

  it '/pusher/auth' do
    assert_generates '/pusher/auth', :controller => 'pusher', :action => 'auth'
  end

  it '/admin_chat/close' do
    assert_generates '/admin_chat/close', :controller => 'admin_chat', :action => 'close'
  end

  it '/admin_chat/send_msg' do
    assert_generates '/admin_chat/send_msg', :controller => 'admin_chat', :action => 'send_msg'
  end

end