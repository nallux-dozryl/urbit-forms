<script>

  import { onMount } from 'svelte'
  import { metas, initMetas, isCreate, createSurvey } from '../UrbitStore' 
  import Request from '../Homepage/Request.svelte'
  import Create from '../Homepage/Create.svelte'
  import MyForms from '../Homepage/MyForms.svelte'
  import ReqForms from '../Homepage/ReqForms.svelte'
  import ArchivedForms from '../Homepage/ArchivedForms.svelte'
  import CreatePage from '../Homepage/CreatePage.svelte'

    onMount(()=> {
        initMetas(window.ship)
    })

</script>

{#if $isCreate === "scratch"}
  <CreatePage />
{:else}
  <div class="logo">forms</div>
  <div class="section">
    <Request />
  </div>
  <div class="section">
    <Create />
  </div>
  <div class="section">
    <MyForms />
  </div>
  <div class="section">
    <ReqForms />
  </div>
  <div class="section">
    <ArchivedForms />
  </div>
{/if}

<style>

  .logo {
    text-align: left;
    margin: .5em;
    font-size: 3em;
    font-weight: 700;
  }

  .section {
    margin-bottom: 2em;
  }

</style>
