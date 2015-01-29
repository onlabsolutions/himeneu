// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require angular/angular.min.js
//= require angular-resource
//= require ng-rails-csrf
//= require jquery.min.js
//= require jquery_ujs
//= require jquery.autosize
//= require moment
//= require bootstrap/dist/js/bootstrap
//= require bootstrap-datetimepicker
//= require raty/lib/jquery.raty
//= require_tree .
//= stub active_admin


$(document).ready(function(){
	$.ajaxSetup({
	  dataType: 'json'
	})

	$('form').bind('ajax:beforeSend', function(event, xhr, status) {

		$(this).before('<img alt="Loading" id="load" class="img-responsive" src="/assets/loading.gif">');

	});

	$('form').bind('ajax:complete', function(event, xhr, status) {
		$("#load").remove();
    alert("Done!");
	});

  $(function () {
    $('[data-toggle="popover"]').popover();
  });

var app = angular.module('App', ['ng-rails-csrf', 'ngResource']);

});



