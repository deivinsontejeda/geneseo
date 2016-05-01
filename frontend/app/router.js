import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('catchall', { path: '/*wildcard' }); // catch everything

  this.route('users', function() {
    this.route('show', { path: '/:user_id' });
  });
});

export default Router;
