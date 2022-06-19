<script>
    // scripts
    import { active, metas, updateMetas } from '../UrbitStore'
    import { onMount } from 'svelte'

    // SideBar
    import TopPanel from '../SideBar/TopPanel.svelte'
    import Surveys from '../SideBar/Surveys.svelte'

    // MainArea
    import CreateSurvey from '../MainArea/CreateSurvey.svelte'
    import RequestSurvey from '../MainArea/RequestSurvey.svelte'
    import SurveyHeader from '../MainArea/SurveyHeader.svelte'

    // states
      let allMeta;
      let cur;
      metas.subscribe(res => {allMeta = res})
      active.subscribe(res => {cur = res})

  // populate surveys
    onMount(() => {
        updateMetas(window.ship, "/metas")
      })

</script>

<div class="full">
    <div class="sidebar">
        <TopPanel />
        {#if allMeta}
            <Surveys surveys={allMeta} /> 
        {:else}
            <span>No forms here!</span>
        {/if}
    </div>
    <div class="main-area">
        {#if cur === "create"}
            <CreateSurvey />
        {:else if cur === "req"}
            <RequestSurvey />
        {:else}
          <SurveyHeader survey={cur} />
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
    height: calc(100vh - 24px);
    overflow: scroll;
  }

  .main-area::-webkit-scrollbar {
    display: none;
  }

</style>
