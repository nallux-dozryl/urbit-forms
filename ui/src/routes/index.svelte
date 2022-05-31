<script>
  import { onMount } from 'svelte'
  import Urbit from '@urbit/http-api'
  import MediaQuery from '../components/MediaQuery.svelte'
  import SurveysNav from '../components/SurveysNav.svelte'
  import RequestSurvey from '../components/RequestSurvey.svelte'
  import CreateSurvey from '../components/CreateSurvey.svelte'
  import { getSurveys, getDefunct } from '../UrbitStore'

    let defunct;
    let surveys;

    onMount(() => {
      getSurveys(window.ship).then(res => surveys = res)
      getDefunct(window.ship).then(res => defunct = res)
    })

    function refreshSurveys(event) {
      getSurveys(event.detail).then(res => surveys = res)
      getDefunct(event.detail).then(res => defunct = res)
    }
</script>

<MediaQuery query="(min-width: 368px)" let:matches>
  {#if matches}
    <div class="homepage">
      <RequestSurvey on:update={refreshSurveys}/>
      <CreateSurvey on:update={refreshSurveys}/>
      <SurveysNav surveys={surveys} defunct={defunct} /> 
    </div>
  {/if}
</MediaQuery>

<style>

  .homepage {
    margin: auto;
    width: 40vw;
  }
</style>
