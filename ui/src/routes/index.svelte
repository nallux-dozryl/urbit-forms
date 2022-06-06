<script>
    // scripts
    import { active, surveys, makeContact } from '../UrbitStore'
    import { onMount } from 'svelte'

    // components
    import TopPanel from '../components/TopPanel.svelte'
    import Surveys from '../components/Surveys.svelte'
    import CreateSurvey from '../components/CreateSurvey.svelte'
    import SurveyPub from '../components/SurveyPub.svelte'
    // states
      let data;
      let activeId;
      surveys.subscribe(res => {data = res})
      active.subscribe(res => {activeId = res})

  // populate surveys
    onMount(() => {
        makeContact(window.ship)
      })

</script>

<div class="full">
  <div class="sidebar">
    <TopPanel />
    {#if data}
      <Surveys surveys={data} /> 
    {:else}
      <span>No forms here!</span>
    {/if}
  </div>
  <div class="main-area">
    {#if activeId }
      <SurveyPub survey={data.find(item => item.id === activeId)} />
      {:else}
      <CreateSurvey />
    {/if}
  </div>
</div>

<style>

  .full {
    display: flex;
    border: 1px solid black;
    height: calc(100vh - 24px);
  }

  .sidebar {
    flex: 1;
    border-right: 2px solid black;
    height: 100%;
  }

  .main-area {
    flex: 3;
    height: calc(100vh -24px);
    overflow: scroll;
  }

  .main-area::-webkit-scrollbar {
    display: none;
  }

</style>
