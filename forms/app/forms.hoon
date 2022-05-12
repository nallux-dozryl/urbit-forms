/-  *forms
/+  default-agent, dbug, forms
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =surveys]
+$  card  card:agent:gall
++  sv-orm   ((on sv-id json) gth)
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  `this(surveys ^+(surveys (~(put by surveys) our.bowl *survey)))
++  on-save  ^-  vase  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
::
++  on-poke   ::on-poke:def
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  (on-poke:def mark vase)
    %noun
      =+  action=!<(action vase)
      ?-  -.action
        %create
          ?>  =(src our):bowl
          ?~  ^-(survey (~(got by surveys) our.bowl))
            =+  surv=^-(survey (put:sv-orm =survey (create-survey:forms action now.bowl)))
            `this(surveys ^+(surveys (~(put by surveys) our.bowl surv)))
          =+  get-surv=^-(survey (~(got by surveys) our.bowl))
          =+  surv=^-(survey (put:sv-orm get-surv (create-survey:forms action now.bowl)))
          `this(surveys ^+(surveys (~(put by surveys) our.bowl surv)))
      ==
  ==
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
