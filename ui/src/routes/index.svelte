

<script>
  import { onMount } from 'svelte'
  import Urbit from '@urbit/http-api'
  import SurveysNav from '../components/SurveysNav.svelte'
  import MediaQuery from '../components/MediaQuery.svelte'

    let surveys = [];
    let defunct = [];

    onMount( async () => {
      console.log("mounted")
      window.urbit = new Urbit("")
      window.urbit.ship = window.ship
      getSurveys()
      getDefunct()
      })

    let getSurveys = async () =>  {
      const response = await window.urbit.scry({
        app: "forms",
        path: "/surveys/live"
      })
      surveys = response
      }

    let getDefunct = async () =>  {
      const response = await window.urbit.scry({
        app: "forms",
        path: "/surveys/defunct"
      })
      defunct = response
      }

</script>

<MediaQuery query="(min-width: 768px)" let:matches>
  {#if matches}
  <div class="homepage">
    <SurveysNav surveys={surveys} defunct={defunct}/>
  </div>
  {/if}
</MediaQuery>

<style>

  .homepage {
    margin: auto;
    width: 40vw;
  }
</style>
