<script>
  // components
  import SurveyTab from './SurveyTab.svelte'
  // props
  export let surveys;
    let tabs = ['live', 'archived', 'owned'];
    let selected;
</script>

<div class="main">
  {#if surveys}
    <select 
      bind:value={selected}
    >
      {#each tabs as tab}
        <option value={tab}>
          {tab}
        </option>
      {/each}
    </select>
    <div class="panel">
    {#if selected === "owned"}
      {#each surveys as { title , author, id }}
        {#if author === window.ship}
          <SurveyTab title={title} author={author} id={id}/>
        {/if}
      {/each}
    {:else}
      {#each surveys as { title, author, status, id }}
        {#if status === selected}
          <SurveyTab title={title} author={author} id={id}/>
        {/if}
      {/each}
    {/if}
    </div>
  {:else}
    <span>yes</span>
  {/if}
</div>

<style>

  .panel {
    height: calc(100vh - 117px);
    overflow: scroll;
  }

  .panel::-webkit-scrollbar {
    display: none;
  }

  select {
    width: 100%;  
    background: none;
    border-bottom: none;
    border-left: none;
    border-right: none;
    border-top: 1px solid black;
    padding: .6em;
  }

</style>
