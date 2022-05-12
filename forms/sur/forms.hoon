|%
+$  sv-author     ship
+$  sv-id         @ud  ::  unix timestamp
+$  survey        ((mop sv-id json) gth)
+$  visibility    ?(%public %private %team)
+$  action
  $%  [%create title=@t description=@t =visibility slug=@ta]
  ==


+$  surveys  (map sv-author survey)
--
