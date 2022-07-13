<script>
  import { active, formSettingsTab, getSubmissions } from '../UrbitStore'
  import { onMount } from 'svelte'
  import Details from './Details.svelte'
  import Invite from './Invite.svelte'
  import Export from './Export.svelte'
  import SectionEdit from '../FormEdit/SectionEdit.svelte'
  import Submissions from '../FormEdit/Submissions.svelte'

  let tab

  formSettingsTab.subscribe(res => tab = res)
  onMount(()=> {
    getSubmissions($active[0].id)
  })

</script>
<div class="container">
{#if $active[0].author === window.ship}
  <button 
    class="tab { tab === 'questions' ? 'active' : '' }"
    on:click={()=> formSettingsTab.set("questions")}
    >
    Questions
  </button>
{/if}
  <button 
    class="tab { tab === 'details' ? 'active' : '' }"
    on:click={()=> formSettingsTab.set("details")}
    >
    Details
  </button>
  <button 
    class="tab { tab === 'submissions' ? 'active' : '' }"
    on:click={()=> formSettingsTab.set("submissions")}
    >
    Submissions
  </button>
</div>
{#if tab === "details"}
  <Details />
{:else if tab === "questions"}
  <SectionEdit />
{:else if tab === "submissions"}
  <Submissions />
{/if}

<style>

  .container {
    padding-top: 3em;
    gap: 1em;
    text-align: center;
  }

  .tab {
    width: 13em;
    border: solid 1px #e9e9e9;
    background: white;
    border-radius: 4px;
    padding: 1em;
  }

  .tab:hover {
    background: grey;
    border-color: grey;
    color: white;
  }

  .active {
    background: black;
    border-color: black;
    color: white;
  }

</style>
