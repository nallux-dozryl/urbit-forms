/-  forms
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =shelf:forms]
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this   .
    def    ~(. (default-agent this %.n) bowl)
::
++  on-init  ^-  (quip card _this)  `this
++  on-save  ^-  vase  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
::
::++  on-poke  on-poke:def
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  (on-poke:def mark vase)
    %noun
      =/  action  !<(action:forms vase)
      ?-  -.action
        %add
          ?>  =(src.bowl our.bowl)
          =+  id=`@uw`(shaf now.bowl eny.bowl)
          ~&  >  [id +.action]
          :-  ~  %=  this
            shelf  ^-  shelf:forms
                (~(put by shelf) id +.action)
          ==
        ::
        %del
        `this
        %req
        ::  takes id and returns statement
        `this
      ==

  ==
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
  ::  receives card and modify state
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
