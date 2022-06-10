<script>
    // scripts
    import { active, metas, updateMetas } from '../UrbitStore'
    import { onMount } from 'svelte'

    // SideBar
    import TopPanel from '../SideBar/TopPanel.svelte'
    import Surveys from '../SideBar/Surveys.svelte'

    // MainArea
    import CreateSurvey from '../MainArea/CreateSurvey.svelte'
    import SurveyPub from '../MainArea/SurveyPub.svelte'
    import RequestSurvey from '../MainArea/RequestSurvey.svelte'

    // states
      let data;
      let stat;
      metas.subscribe(res => {data = res})
      active.subscribe(res => {stat = res})

  // populate surveys
    onMount(() => {
        updateMetas(window.ship, "/metas")
        console.log(window.ship)
      })

</script>

<div class="full">
    <div class="sidebar">
        <TopPanel />
        {#if data}
            <Surveys surveys={data} /> 
            {console.log(data[0].author)}
        {:else}
            <span>No forms here!</span>
        {/if}
    </div>
    <div class="main-area">
        {#if stat === "create"}
            <CreateSurvey />
        {:else if stat === "req"}
            <RequestSurvey />
        {:else}
            <SurveyPub survey={stat} />
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
