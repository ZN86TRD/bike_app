// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//プレビュー機能(選択時に実行)
$(document).on('turbolinks:load', function() {
  //プロフィール画像プレビュー
  $('#user-image-input').on('change', function(e) {
    const file = e.target.files[0];
    const reader = new FileReader();

    if (file && file.type.match('image.*')) {
      reader.onload = function(e) {
        $('#image-preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(file);
    }
  });

  //ガレージ機能プレビュー
  $('#bike-image-input').on('change', function(e) {
    const file = e.target.files[0];
    const reader = new FileReader();

    if (file && file.type.match('image.*')) {
      reader.onload = function(e) {
        $('#bike-image-preview').attr('src', e.target.result);
        $('#bike-preview-container').removeClass('d-none');
      }
      reader.readAsDataURL(file);
    }
  });

  //新規投稿プレビュー
  $('#post-image-input').on('change', function(e) {
    const file = e.target.files[0];
    const reader = new FileReader();

    if (file && file.type.match('image.*')) {
      reader.onload = function(e) {
        $('#post-image-preview').attr('src', e.target.result);
        $('#post-preview-container').removeClass('d-none');
      }
      reader.readAsDataURL(file);
    }
  });
});