<script>
  import Surveys from './Surveys.svelte';
  export let surveys;
  export let defunct;

  let tab = "all"

    function setAll() {
      tab = "all"
      }

    function setOwn() {
      tab = "own"
      }

</script>
  <div class="nav">
    <button 
      on:click={()=> tab = "all"} 
      class="nav-item { (tab === "all") ? "active" : "inactive" }"
    >
      All
    </button>
    <button 
      on:click={()=> tab = "own"} 
      class="nav-item { (tab === "own") ? "active" : "inactive" }"
    >
      Owned
    </button>
    <button 
      on:click={()=> tab = "def"} 
      class="nav-item { (tab === "def") ? "active" : "inactive" }"
    >
      Defunct
    </button>
  </div>
  {#if (tab === "def")}
    {#each defunct as { author, title }}
      <Surveys title={title} author={author}/>
    {/each}
  {:else}
    {#each surveys as { author, title }}
      {#if (tab === "all")}
        <Surveys title={title} author={author}/>
      {/if}
      {#if (tab === "own" && author === window.ship)}
        <Surveys title={title} author={author}/>
      {/if}
    {/each}
  {/if}

<style>

  .nav {
    display: flex;
    margin: 0 0 10px 2px;
    border-bottom: 2px solid black;
  }

  .nav-item {
    flex: 1; 
    padding: 8px 0 8px 0;
  }

  .active {
    background: black;
    color: white;
    border: none;
  }

  .inactive {
    background: white;
    color: black;
    border: none;
  }

</style>
