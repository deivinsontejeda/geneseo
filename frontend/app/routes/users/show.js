import Ember from 'ember';
import config from  './../../config/environment';

const { inject } = Ember;

export default Ember.Route.extend({
  request: inject.service(),

  model(params) {
    let options = {
      url: `${config.API_HOST}/api/v1/users/${params.user_id}`
    };

    return this.get('request').perform(options)
      .then((response) => {
        return response;
      });
  }
});
