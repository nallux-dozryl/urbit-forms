/-  *forms
/+  default-agent, dbug, fl=forms
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    =shelf
    =slugs
    =pending
  ==
+$  card  card:agent:gall
++  s-orm   ((on sv-id survey) gth)
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
  `this(shelf ^+(shelf (~(put by shelf) our.bowl *surveys)))
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
    %forms-action
      =+  act=!<(action vase)
      ?-  -.act
        %create
        =+  id=(make-survey-id:fl now.bowl)
        ?>  =(src our):bowl
        =+  slg=(~(put by slugs) slug.act id)
        =+  data=(create-survey:fl act)
        =+  surv=(~(got by shelf) our.bowl)
        =+  survs=(put:s-orm surv id data) 
        =+  new-shelf=^+(shelf (~(put by shelf) our.bowl survs))
        `this(slugs slg, shelf new-shelf)
        ::
        %ask
        ?>  =(src our):bowl
        :_
          %=  this  pending 
          ^+  pending
          %-  ~(put in pending)
            [sv-author.act slug.act]
          ==
        :~  :*
          %pass   /request
          %agent  [sv-author.act %forms]
          %poke   %forms-action  !>  [%request slug.act]
        ==  ==
        ::
        %request
        ~|  'form does not exist'
        =+  id=(need (~(get by slugs) slug.act))
        =+  survs=(need (~(get by shelf) our.bowl))
        =+  surv=^-(survey (need (get:s-orm survs id)))
        =+  vis=(~(got by surv) 'visibility')
        ?<  =(vis %private)
        :_  this
        :~  :*
          %pass   /survey
          %agent  [src.bowl %forms]
          %poke   %forms-action  !>  [%receive slug.act id]
        ==  ==
        ::
        %receive
        =/  new-pending  ^+  pending
          (~(del in pending) [src.bowl slug.act])
        :_  this(pending new-pending)
        :~  :*
          %pass   /survey/(scot %p src.bowl)/(scot %ud sv-id.act)
          %agent  [src.bowl %forms]
          %watch  /request/(scot %p src.bowl)/(scot %ud sv-id.act)
        ==  ==
        ::
        %unsub  :: temp
        :_  this
        :~  :*
          %pass   /survey/(scot %p sv-author.act)/(scot %ud sv-id.act)
          %agent  [sv-author.act %forms]
          %leave  ~
        ==  ==
      ==
  ==
::
++  on-watch  ::on-watch:def
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
    [%request * * ~]
    =+  id=(slav %ud (snag 2 `(list @ta)`path))
    =+  survs=(need (~(get by shelf) our.bowl))
    =+  surv=^-(survey (need (get:s-orm survs id)))
    :_  this
    :~  :*
      %give  %fact   ~
      %forms-update  !>(survey+surv)
    ==  ==
  ==
::
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  ::on-agent:def
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+  wire  (on-agent:def wire sign)
    [%request ~]
      ?.  ?=(%poke-ack -.sign)  (on-agent:def wire sign)
      ?~  p.sign  `this
      %-  %-  slog  ^-  tang  (need p.sign)  `this
    ::
    [%survey * * ~]
      ?+  -.sign  (on-agent:def wire sign)
        %watch-ack
        ~&  >  'you have been watch ackedddd'
        ?~  p.sign  `this
        %-  %-  slog  ^-  tang  (need p.sign)  `this
        ::
        %kick
        ~&  >  'you have been kickeddddd'
        =+  id=(snag 2 `(list @ta)`wire)
        :_  this
        ~
        :::~  :*
        ::  %pass   [~.survey (scot %p src.bowl) id ~]
        ::  %agent  [src.bowl %forms]
        ::  %watch  [~.request (scot %p src.bowl) id ~]
        ::==  ==
        ::
        %fact
        ~&  >  'you have been faccccct'
        ?+  p.cage.sign  (on-agent:def wire sign)
          %forms-update
          =+  update=!<(update q.cage.sign)
          ~&  >>  update
          `this
        ==
      ==
  == 
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
