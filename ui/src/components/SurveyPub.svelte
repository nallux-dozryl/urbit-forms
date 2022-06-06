<script>
  //imports
  import SurveyHeader from './SurveyHeader.svelte'
  import Statement from '../questions/Statement.svelte'
  import Short from '../questions/Short.svelte'
  import Long from '../questions/Long.svelte'
  import One from '../questions/One.svelte'
  import Many from '../questions/Many.svelte'
  import LinearDisc from '../questions/LinearDisc.svelte'
  import LinearCont from '../questions/LinearCont.svelte'

 
  export let survey;

</script>
<div class="container">
  <SurveyHeader
      title={survey.title}
      description={survey.description}
      author={survey.author}
      slug={survey.slug}
  />
  <Statement />
  <Short />
  <Long />
  <One />
  <Many />
  <LinearDisc />
  <LinearCont />
</div>
<style>

  .container {
    width: 80%;
    margin: auto;
  }

</style>
