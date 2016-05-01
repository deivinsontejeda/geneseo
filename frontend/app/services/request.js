import Ember from 'ember';
import object from 'lodash/object';

/**
 * This service wrap any remote call which needs authorization
 * in order to set necessary headers to being authorized
 * once the user is logged in
 *
 */

export default Ember.Service.extend({

  ajaxOptions() {
    return {
      method: 'GET',
      dataType: 'json',
      beforeSend: (xhr) => {
        xhr.setRequestHeader('Authorization', `Bearer custom`);
      }
    };
  },
  /**
   * This is a private API
   */
  perform(options) {
    return Ember.$.ajax(object.assign(this.ajaxOptions(), options));
  }
});
