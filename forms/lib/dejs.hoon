/-  *forms
/+  *forms
|%
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action
  %.  jon
  %-  of
    :~
      delsubmission+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so) rid+(cu |=(x=@ta (slav %ud x)) so)])
      submit+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so)])
      delete+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so)])
      :-  %ask
      %-  ot
        :~
          author+(cu |=(x=@ta `@p`(slav %p x)) so)
          slug+so
        ==
      :-  %create
      %-  ot 
        :~  
          title+so
          description+so 
          visibility+(cu |=(x=@tas ?>(?=(visibility x) `visibility`x)) so) 
          slug+so 
          rlimit+ni
        ==
      :-  %editdraft
      %-  ot
      :~
        id+(cu |=(x=@ta (slav %ud x)) so)
        sid+ni
        qid+ni
        head+(cu |=(x=@tas ?>(?=(%answer x) `%answer`x)) so)
        accept+so
        a+(ar so)
        b+(ar (ot ~[x+so y+so]))
        c+(ar (ot ~[x+so y+so z+so]))
      ==
    ==
  ::
++  dejs-edit
  =,  dejs:format
  |=  jon=json
  ^-  edit
  %.  jon
  %-  of
    :~
      delsection+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so) sid+ni])
      addsection+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so) sid+ni])
      title+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so) title+so])
      description+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so) description+so])
      slug+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so) slug+so])
      rlimit+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so) rlimit+ni])
      delquestion+(ot ~[id+(cu |=(x=@ta (slav %ud x)) so) sid+ni qid+ni])
      :-  %visibility
      %-  ot
      :~
        id+(cu |=(x=@ta (slav %ud x)) so)
        vis+(cu |=(x=@tas ?>(?=(visibility x) `visibility`x)) so) 
      ==
      :-  %addquestion
      %-  ot 
      :~
        id+(cu |=(x=@ta (slav %ud x)) so)
        sid+ni
        qid+ni
        head+(cu |=(x=@tas ?>(?=(%question x) `%question`x)) so)
        display+so
        accept+so
        required+bo
        min+ni
        max+ni
        x+(ar so)
        y+(ar so)
        z+(ar so)
        statements+(ar (ot ~[x+(ar so) y+(ar so) z+(ar so) display+so]))
      ==
    ==
--
