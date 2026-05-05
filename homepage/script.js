document.addEventListener('DOMContentLoaded', () => {
    // Initialize Lucide icons
    lucide.createIcons();

    // Navbar scroll effect
    const navbar = document.querySelector('.navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.style.background = 'rgba(255, 255, 255, 0.9)';
            navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.05)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.6)';
            navbar.style.boxShadow = '0 8px 32px rgba(31, 38, 135, 0.07)';
        }
    });

    // Intersection Observer for scroll animations
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.15
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, observerOptions);

    const fadeElements = document.querySelectorAll('.fade-up');
    fadeElements.forEach(el => observer.observe(el));

    // Modals Logic
    const modalContainer = document.getElementById('modal-container');
    const modalTitle = document.getElementById('modal-title');
    const modalBody = document.getElementById('modal-body');
    const closeModalBtn = document.querySelector('.close-modal');

    const openModal = (title, contentHtml) => {
        modalTitle.innerText = title;
        modalBody.innerHTML = contentHtml;
        modalContainer.classList.add('active');
        document.body.style.overflow = 'hidden';
    };

    const closeModal = () => {
        modalContainer.classList.remove('active');
        document.body.style.overflow = 'auto';
    };

    closeModalBtn.addEventListener('click', closeModal);
    modalContainer.addEventListener('click', (e) => {
        if (e.target === modalContainer) closeModal();
    });

    // Ranks Data & Generator
    const rankGroups = [
        { name: '🌱 비기너', costs: ['10G', '20G', '30G', '40G', '50G'] },
        { name: '👟 트래블러', costs: ['80G', '100G', '120G', '140G', '160G'] },
        { name: '🧭 익스플로러', costs: ['250G', '300G', '350G', '400G', '450G'] },
        { name: '🏆 베테랑', costs: ['600G', '700G', '800G', '900G', '1,000G'] },
        { name: '👑 마스터', costs: ['1,500G', '1,800G', '2,100G', '2,400G', '2,700G'] },
        { name: '✨ 레전드', costs: ['4,000G', '5,000G', '6,500G', '8,000G', '10,000G'] }
    ];

    document.getElementById('view-ranks').addEventListener('click', () => {
        let html = '<p style="color: #6b7280; margin-bottom: 20px;">골드를 모아 당신의 랭크를 업그레이드하세요.</p>';
        rankGroups.forEach(group => {
            html += `
                <div class="rank-group">
                    <h4>${group.name}</h4>
                    <div class="rank-list">
                        ${group.costs.map((cost, i) => `
                            <div class="rank-item">
                                <span>Lv.${i+1}</span>
                                <strong>${cost}</strong>
                            </div>
                        `).join('')}
                    </div>
                </div>
            `;
        });
        openModal('📈 전체 랭크 시스템', html);
    });

    // Achievements Data & Generator
    const achievements = [
        { title: '라팁과의 첫 만남', desc: '첫 로그인 성공', reward: '5G' },
        { title: '동네 산책', desc: '누적 300m 달성', reward: '5G' },
        { title: '전국 일주', desc: '17개 시/도 방문', reward: '1,000G', special: true },
        { title: '지구 한 바퀴', desc: '누적 40,000km 달성', reward: '5,000G', special: true },
        { title: '나침반(동/서/남/북)', desc: '대한민국 끝단 방문', reward: '1,500G/각' },
        { title: '라팁의 고인물', desc: '100일 연속 기록', reward: '2,000G', special: true },
        { title: '라팁 마스터', desc: '누적 리뷰 200개 달성', reward: '3,000G', special: true }
    ];

    document.getElementById('view-achievements').addEventListener('click', () => {
        let html = '<p style="color: #6b7280; margin-bottom: 20px;">모든 이동과 기록이 당신의 커리어가 됩니다.</p><div class="ach-list">';
        achievements.forEach(ach => {
            html += `
                <div class="ach-card ${ach.special ? 'special' : ''}">
                    <div class="ach-info">
                        <h4>${ach.title}</h4>
                        <p>${ach.desc}</p>
                    </div>
                    <div class="ach-reward-text ${ach.special ? 'orange' : ''}">${ach.reward}</div>
                </div>
            `;
        });
        html += '</div>';
        openModal('🏅 라팁 업적 리스트', html);
    });

    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            if(targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
});
