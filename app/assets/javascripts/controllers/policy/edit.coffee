Whistlr.PolicyEditController = Ember.ObjectController.extend(
  Whistlr.FormPolicyMixin

  actions:
    submit: (event, view) ->
      @get('model').save().then ((response) =>
        Whistlr.setFlash(Em.I18n.t("flash.resource_edited"), 'notice')
        @transitionToRoute('policy.timeline', @content)
      ), (response) =>
        @set "errors", response.errors
)